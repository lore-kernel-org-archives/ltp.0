From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 May 2018 17:13:37 +0200
Subject: [LTP] [PATCH v3 1/3] lib/tst_checksum: add crc32c checksum
In-Reply-To: <b2cc2d7f-7ff7-3c4d-a01d-bebc726e56e2@oracle.com>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
 <20180503130608.fv43iyrtep2diwzz@dell5510>
 <b2cc2d7f-7ff7-3c4d-a01d-bebc726e56e2@oracle.com>
Message-ID: <20180504151337.a2oshluy4phahtec@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > BTW sctp_big_chunk still uses crazy big load on kernels before 4.17 rc2 :(.

> I wonder, what is the time the test needs to complete on your system,
> could you post the numbers at least from 'time' command? Does it take
> minutes? I've not seen it takes more than a second.
I'm testing it on several OS (SLES 15, Centos 7, Debian 9, ...) which all have kernels
older than 4.17-rc2. It behaves like DOS - the only thing I can do is to restart machines :(.
With vanilla kernel 4.17-rc2 it works well.

> Will remove sending this packet 3 times, it should be enough to send
> it just once. I assume, the load is on the server, in the kernel?
> i.e. when it receives and processes that INIT packet.

> What is the time in 4.17-rc2 with this change:
I'll let you know.

> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index 333e502..c663f71 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -109,11 +109,11 @@ static void setup_client(void)
>         uint16_t param_len = htons(20);

>         /* IPv6(40) + SCTP_COMMON(12) + SCTP_CHUNK(20) + SCTP_OPT(65460)) */
> -       for (i = 0; i < addr_num; ++i) {
> +       for (i = 1; i <= addr_num; ++i) {
>                 update_packet_field(&off, &param_type, 2);
>                 update_packet_field(&off, &param_len, 2);
> -               packet[off + 15] = 1;
> -               off += 16;
> +               off += 12;
> +               update_packet_field(&off, &i, 4);
>         }
>         pkt_len = off;

> when we are using unique addresses...


Kind regards,
Petr
