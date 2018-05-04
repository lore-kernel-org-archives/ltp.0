From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 4 May 2018 13:50:27 +0300
Subject: [LTP] [PATCH v3 1/3] lib/tst_checksum: add crc32c checksum
In-Reply-To: <20180503130608.fv43iyrtep2diwzz@dell5510>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
 <20180503130608.fv43iyrtep2diwzz@dell5510>
Message-ID: <b2cc2d7f-7ff7-3c4d-a01d-bebc726e56e2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/03/2018 04:06 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> It will be used to make a SCTP packet in the test.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>> v3: use SPDX License-Identifier
> 
>> v2: As suggested by Cyril:
>>     * updated the docs, added section 2.2.25
>>     * added 'tst_' prefix
>>     * changed type 'int' to 'size_t' for the buffer length
> 
>>  doc/test-writing-guidelines.txt |    6 +++
>>  include/tst_checksum.h          |   16 ++++++++
>>  lib/tst_checksum.c              |   81 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 103 insertions(+), 0 deletions(-)
>>  create mode 100644 include/tst_checksum.h
>>  create mode 100644 lib/tst_checksum.c
> 
> Whole patchset LGTM.
> 
> BTW sctp_big_chunk still uses crazy big load on kernels before 4.17 rc2 :(.


I wonder, what is the time the test needs to complete on your system,
could you post the numbers at least from 'time' command? Does it take
minutes? I've not seen it takes more than a second.

Will remove sending this packet 3 times, it should be enough to send
it just once. I assume, the load is on the server, in the kernel?
i.e. when it receives and processes that INIT packet.

What is the time in 4.17-rc2 with this change:

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 333e502..c663f71 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -109,11 +109,11 @@ static void setup_client(void)
        uint16_t param_len = htons(20);

        /* IPv6(40) + SCTP_COMMON(12) + SCTP_CHUNK(20) + SCTP_OPT(65460)) */
-       for (i = 0; i < addr_num; ++i) {
+       for (i = 1; i <= addr_num; ++i) {
                update_packet_field(&off, &param_type, 2);
                update_packet_field(&off, &param_len, 2);
-               packet[off + 15] = 1;
-               off += 16;
+               off += 12;
+               update_packet_field(&off, &i, 4);
        }
        pkt_len = off;

when we are using unique addresses...
