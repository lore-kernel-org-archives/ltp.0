From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 30 Jul 2020 15:00:24 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <20200729143451.GG7152@yuki.lan>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729143451.GG7152@yuki.lan>
Message-ID: <320f25e9-f0e7-73a9-fe43-284befcce1e2@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   include/libnewipc.h           |  28 ++++------
>>   libs/libltpnewipc/libnewipc.c | 101 ++++++++++++++++++++++++++++++++--
>>   2 files changed, 109 insertions(+), 20 deletions(-)
> 
> Just FYI we do not have to put all the code into a single *.c file, we
> can have as many as we want in the library directory...
I remember you have some comments on my previous patach as below:
------------------------------
So unless we plan to use it from different tests it does not make much
sense to export it to the top level include and libs.

Or alternatively we do have libltpnewipc we can pust put the
libnewmsgctl.c to that directory and with that we will have a single
System V IPC helper library.
------------------------------

So I merge libnewmsgctl.c into libnewipc.c.

ps: IMO, libnewipc has only three functions(getipckey,get_used_queues, 
probe_free_addr) ,It's hard to call it a LIBS library. Can we put it 
into lib directory and named it as tst_ipc.c?
@LI, What do you think about this?

> 
>>
>> diff --git a/include/libnewipc.h b/include/libnewipc.h
>> index 30288cd68..1256c4668 100644
>> --- a/include/libnewipc.h
>> +++ b/include/libnewipc.h
>> @@ -1,21 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
>>    *
>> - * This program is free software;  you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - * the GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program.
>> - */
>> -
>> -/*
>>    * common definitions for the IPC system calls.
>>    */
> 
> Ideally the changes in comments should be in a separate patch from
> functional changes.
Yes.
> 
>> @@ -56,4 +42,14 @@ void *probe_free_addr(const char *file, const int lineno);
>>   #define PROBE_FREE_ADDR() \
>>   	probe_free_addr(__FILE__, __LINE__)
>>   
>> -#endif /* newlibipc.h */
>> +void do_read(const char *file, const int lineno, long key, int tid, \
>> +	     long type, int child, int nreps);
>> +#define DO_READ(key, tid, type, child, nreps) \
>> +	do_read(__FILE__, __LINE__, (key), (tid), (type), (child), (nreps))
>> +
>> +void do_writer(const char *file, const int lineno, long key, int tid, \
>> +	       long type, int child, int nreps);
>> +#define DO_WRITER(key, tid, type, child, nreps) \
>> +	do_writer(__FILE__, __LINE__, (key), (tid), (type), (child), (nreps))
> 
> The naming here is a bit inconsistent, either we should have do_reader()
> and do_writer() or do_read() and do_write(), but mixing them like this
> is strange choice.
Sorry. Yes, I did't notice this. I will do_writer/do_reader pair.
> 
>> +#endif /* libnewipc.h */
>> diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
>> index 3734040b7..4980ce078 100644
>> --- a/libs/libltpnewipc/libnewipc.c
>> +++ b/libs/libltpnewipc/libnewipc.c
>> @@ -1,10 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
>> - */
>> -
>> -/*
>> - * DESCRIPTION
>> + *
>>    * common routines for the IPC system call tests.
>>    */
>>   
>> @@ -26,6 +23,14 @@
>>   
>>   #define BUFSIZE 1024
>>   
>> +struct mbuffer {
>> +	long type;
>> +	struct {
>> +		char len;
>> +		char pbytes[99];
>> +	} data;
>> +};
>> +
>>   key_t getipckey(const char *file, const int lineno)
>>   {
>>   	char buf[BUFSIZE];
>> @@ -86,3 +91,91 @@ void *probe_free_addr(const char *file, const int lineno)
>>   
>>   	return addr;
>>   }
>> +
>> +int verify(char *buf, char val, int size, int child)
>> +{
>> +	while (size-- > 0) {
>> +		if (*buf++ != val) {
>> +			tst_res(TFAIL, "Verify error in child %d, *buf = %x, "
>> +				"val = %x, size = %d\n", child, *buf, val,
>> +				size);
>> +			return 1;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +void do_reader(const char *file, const int lineno, long key, int tid,
>> +	       long type, int child, int nreps)
>> +{
>> +	int i, size;
>> +	int id;
>> +	struct mbuffer buffer;
>> +
>> +	id = safe_msgget(file, lineno, key, 0);
>> +	if (id != tid) {
>> +		tst_res(TFAIL,
>> +			"Message queue mismatch in the reader of child group"
>> +			" %d for message queue id %d\n", child, id);
>> +		return;
>> +	}
>> +	for (i = 0; i < nreps; i++) {
>> +		memset(&buffer, 0, sizeof(buffer));
>> +
>> +		size = safe_msgrcv(file, lineno, id, &buffer, 100, type, 0);
>> +		if (buffer.type != type) {
>> +			tst_res(TFAIL, "Type mismatch in child %d, read #%d, "
>> +				"for message got %ld, exected %ld",
>> +				child, (i + 1), buffer.type, type);
>> +			return;
>> +		}
>> +		if (buffer.data.len + 1 != size) {
>> +			tst_res(TFAIL, "Size mismatch in child %d, read #%d, "
>> +				"for message got %d, expected %d",
>> +				child, (i + 1), buffer.data.len + 1, size);
>> +			return;
>> +		}
>> +		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
>> +			tst_res(TFAIL, "Verify failed in child %d read # = %d, "
>> +				"key = %lx\n", child, (i + 1), key);
>> +			return;
>> +		}
>> +		key++;
>> +	}
>> +}
>> +
>> +void fill_buffer(char *buf, char val, int size)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < size; i++)
>> +		buf[i] = val;
>> +}
>> +
>> +void do_writer(const char *file, const int lineno, long key, int tid,
>> +	       long type, int child, int nreps)
>> +{
>> +	int i, size;
>> +	int id;
>> +	struct mbuffer buffer;
>> +
>> +	id = safe_msgget(file, lineno, key, 0);
>> +	if (id != tid) {
>> +		tst_res(TFAIL, "Message queue mismatch in the reader of child"
>> +			" group %d for message queue id %d\n", child, id);
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < nreps; i++) {
>> +		memset(&buffer, 0, sizeof(buffer));
>> +
>> +		do {
>> +			size = (lrand48() % 99);
>> +		} while (size == 0);
>> +		fill_buffer(buffer.data.pbytes, (key % 255), size);
>> +		buffer.data.len = size;
>> +		buffer.type = type;
>> +		safe_msgsnd(file, lineno, id, &buffer, size + 1, 0);
>> +		key++;
>> +	}
>> +}
>> -- 
>> 2.23.0
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


