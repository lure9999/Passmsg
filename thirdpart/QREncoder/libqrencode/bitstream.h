/*
 * qrencode - QR Code encoder
 *
 * Binary sequence class.
 * Copyright (C) 2006, 2007, 2008, 2009 Kentaro Fukuchi <fukuchi@megaui.net>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 */

#ifndef __BITSTREAM_H__
#define __BITSTREAM_H__

typedef struct {
	long length;
	unsigned char *data;
} BitStream;

extern BitStream *BitStream_new(void);
extern long BitStream_append(BitStream *bstream, BitStream *arg);
extern long BitStream_appendNum(BitStream *bstream, long bits, unsigned long num);
extern long BitStream_appendBytes(BitStream *bstream, long size, unsigned char *data);
#define BitStream_size(__bstream__) (__bstream__->length)
extern unsigned char *BitStream_toByte(BitStream *bstream);
extern void BitStream_free(BitStream *bstream);

#endif /* __BITSTREAM_H__ */
