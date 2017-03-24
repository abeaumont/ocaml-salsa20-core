#include <stdint.h>

uint32_t r(uint32_t a, int b) {
  int rs = 32 - b;
  return (a << b) | (a >> rs);
}

uint32_t combine(uint32_t y0, uint32_t y1, uint32_t y2, int shift) {
  return r(y1 + y2, shift) ^ y0;
}

void quarterround(uint32_t *x, int y0, int y1, int y2, int y3) {
  x[y1] = combine(x[y1], x[y0], x[y3], 7);
  x[y2] = combine(x[y2], x[y1], x[y0], 9);
  x[y3] = combine(x[y3], x[y2], x[y1], 13);
  x[y0] = combine(x[y0], x[y3], x[y2], 18);
}

uint32_t get_u32_le(uint8_t *input, int offset) {
  return input[offset]
    | (input[offset + 1] << 8)
    | (input[offset + 2] << 16)
    | (input[offset + 3] << 24);
}

void set_u32_le(uint8_t *input, int offset, uint32_t value) {
  input[offset] = value & 0xff;
  input[offset + 1] = (value >> 8) & 0xff;
  input[offset + 2] = (value >> 16) & 0xff;
  input[offset + 3] = (value >> 24) & 0xff;
}

void salsa_core(int count, uint8_t *hash) {
  uint32_t x[16];
  for (int i = 0; i < 16; i++) {
    x[i] = get_u32_le(hash, i * 4);
  }
  for (int i = 0; i < count; i++) {
    quarterround(x, 0, 4, 8, 12);
    quarterround(x, 5, 9, 13, 1);
    quarterround(x, 10, 14, 2, 6);
    quarterround(x, 15, 3, 7, 11);

    quarterround(x, 0, 1, 2, 3);
    quarterround(x, 5, 6, 7, 4);
    quarterround(x, 10, 11, 8, 9);
    quarterround(x, 15, 12, 13, 14);
  }
  for (int i = 0; i < 16; i++) {
    uint32_t xi = x[i];
    uint32_t hj = get_u32_le(hash, i * 4);
    set_u32_le(hash, i * 4, xi + hj);
  }
}
  
void salsa20_8_core(uint8_t *hash) {
  salsa_core(4, hash);
}

void salsa20_12_core(uint8_t *hash) {
  salsa_core(6, hash);
}

void salsa20_20_core(uint8_t *hash) {
  salsa_core(10, hash);
}

int main () {
  uint8_t hash[64] = {
    0x06, 0x7c, 0x53, 0x92, 0x26, 0xbf, 0x09, 0x32,
    0x04, 0xa1, 0x2f, 0xde, 0x7a, 0xb6, 0xdf, 0xb9,
    0x4b, 0x1b, 0x00, 0xd8, 0x10, 0x7a, 0x07, 0x59,
    0xa2, 0x68, 0x65, 0x93, 0xd5, 0x15, 0x36, 0x5f,
    0xe1, 0xfd, 0x8b, 0xb0, 0x69, 0x84, 0x17, 0x74,
    0x4c, 0x29, 0xb0, 0xcf, 0xdd, 0x22, 0x9d, 0x6c,
    0x5e, 0x5e, 0x63, 0x34, 0x5a, 0x75, 0x5b, 0xdc,
    0x92, 0xbe, 0xef, 0x8f, 0xc4, 0xb0, 0x82, 0xba
  };
  for (int i = 0; i < 1000000; i++) {
    salsa20_20_core(hash);
  }
}
