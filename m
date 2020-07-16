From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2020 09:07:52 +0800
Subject: [LTP] [PATCH v2 1/2] libs/libltpnewipc: Add libnewmsgctl.c
In-Reply-To: <96be4c61-2163-527a-3981-f442812fcba0@cn.fujitsu.com>
References: <20200618094139.24579-1-xuyang_jy_0410@163.com>
 <96be4c61-2163-527a-3981-f442812fcba0@cn.fujitsu.com>
Message-ID: <a955f851-5632-d8ec-725c-6e2f01a1a119@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Does anyone have some comment for this patch set?

Best Regards
Yang Xu
> Hi
> If we convert msgstress test cases into new api with using 
> libnewmsgctl.c, the old libmsgctl.c is useless and we can remove them.
> 
> Best Regards
> Yang Xu
>> From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>
>> Add libnewmsgctl.c into ltp new ipc libs, so the upcoming msgstress 
>> cleanup cases
>> can use doreader/dowirter functions such as old libmsgctl.c does.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>> ? include/libnewmsgctl.h?????????? |? 22 +++++++
>> ? libs/libltpnewipc/libnewmsgctl.c | 102 +++++++++++++++++++++++++++++++
>> ? 2 files changed, 124 insertions(+)
>> ? create mode 100644 include/libnewmsgctl.h
>> ? create mode 100644 libs/libltpnewipc/libnewmsgctl.c
>>
>> diff --git a/include/libnewmsgctl.h b/include/libnewmsgctl.h
>> new file mode 100644
>> index 000000000..e48a04277
>> --- /dev/null
>> +++ b/include/libnewmsgctl.h
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>> + */
>> +
>> +#ifndef __LIBNEWMSGCTL_H__
>> +#define __LIBNEWMSGCTL_H__
>> +
>> +struct mbuffer {
>> +??? long type;
>> +??? struct {
>> +??????? char len;
>> +??????? char pbytes[99];
>> +??? } data;
>> +};
>> +
>> +void doreader(long key, int tid, long type, int child, int nreps);
>> +void dowriter(long key, int tid, long type, int child, int nreps);
>> +void fill_buffer(char *buf, char val, int size);
>> +int verify(char *buf, char val, int size, int child);
>> +
>> +#endif /*__LIBNEWMSGCTL_H__ */
>> diff --git a/libs/libltpnewipc/libnewmsgctl.c 
>> b/libs/libltpnewipc/libnewmsgctl.c
>> new file mode 100644
>> index 000000000..1f6eed74a
>> --- /dev/null
>> +++ b/libs/libltpnewipc/libnewmsgctl.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
>> + */
>> +
>> +#include <errno.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/stat.h>
>> +#include <sys/types.h>
>> +#include <sys/ipc.h>
>> +#include <sys/msg.h>
>> +
>> +#define TST_NO_DEFAULT_MAIN
>> +#include "tst_test.h"
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "libnewmsgctl.h"
>> +
>> +void doreader(long key, int tid, long type, int child, int nreps)
>> +{
>> +??? int i, size;
>> +??? int id;
>> +??? struct mbuffer buffer;
>> +
>> +??? id = SAFE_MSGGET(key, 0);
>> +??? if (id != tid) {
>> +??????? tst_res(TFAIL,
>> +??????????? "Message queue mismatch in the reader of child group %d 
>> for message queue id %d\n",
>> +??????????? child, id);
>> +??????? return;
>> +??? }
>> +??? for (i = 0; i < nreps; i++) {
>> +??????? memset(&buffer, 0, sizeof(buffer));
>> +
>> +??????? size = SAFE_MSGRCV(id, &buffer, 100, type, 0);
>> +??????? if (buffer.type != type) {
>> +??????????? tst_res(TFAIL, "Type mismatch in child %d, read #%d, for 
>> message got %ld, exected %ld",
>> +??????????????? child, (i + 1), buffer.type, type);
>> +??????????? return;
>> +??????? }
>> +??????? if (buffer.data.len + 1 != size) {
>> +??????????? tst_res(TFAIL, "Size mismatch in child %d, read #%d, for 
>> message got %d, expected %d",
>> +??????????????? child, (i + 1), buffer.data.len + 1, size);
>> +??????????? return;
>> +??????? }
>> +??????? if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
>> +??????????? tst_res(TFAIL, "Verify failed in child %d read # = %d, 
>> key = %lx\n",
>> +??????????????? child, (i + 1), key);
>> +??????????? return;
>> +??????? }
>> +??????? key++;
>> +??? }
>> +}
>> +
>> +void dowriter(long key, int tid, long type, int child, int nreps)
>> +{
>> +??? int i, size;
>> +??? int id;
>> +??? struct mbuffer buffer;
>> +
>> +??? id = SAFE_MSGGET(key, 0);
>> +??? if (id != tid) {
>> +??????? tst_res(TFAIL, "Message queue mismatch in the reader of child 
>> group %d for message queue id %d\n",
>> +??????????? child, id);
>> +??????? return;
>> +??? }
>> +
>> +??? for (i = 0; i < nreps; i++) {
>> +??????? memset(&buffer, 0, sizeof(buffer));
>> +
>> +??????? do {
>> +??????????? size = (lrand48() % 99);
>> +??????? } while (size == 0);
>> +??????? fill_buffer(buffer.data.pbytes, (key % 255), size);
>> +??????? buffer.data.len = size;
>> +??????? buffer.type = type;
>> +??????? SAFE_MSGSND(id, &buffer, size + 1, 0);
>> +??????? key++;
>> +??? }
>> +}
>> +
>> +void fill_buffer(char *buf, char val, int size)
>> +{
>> +??? int i;
>> +
>> +??? for (i = 0; i < size; i++)
>> +??????? buf[i] = val;
>> +}
>> +
>> +/* Check a buffer for correct values */
>> +int verify(char *buf, char val, int size, int child)
>> +{
>> +??? while (size-- > 0) {
>> +??????? if (*buf++ != val) {
>> +??????????? tst_res(TFAIL, "Verify error in child %d, *buf = %x, val 
>> = %x, size = %d\n",
>> +??????????????? child, *buf, val, size);
>> +??????????? return 1;
>> +??????? }
>> +??? }
>> +??? return 0;
>> +}
>>


