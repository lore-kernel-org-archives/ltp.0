From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Apr 2018 08:25:42 +0200
Subject: [LTP] [PATCH 2/2] network/vxlan: Fix getopts parameters passed
 from vxlan03 to virt_lib.sh
In-Reply-To: <09e656ed-db47-a1dc-33ec-77d795f81555@oracle.com>
References: <20180428135921.9622-1-pvorel@suse.cz>
 <20180428135921.9622-3-pvorel@suse.cz>
 <09e656ed-db47-a1dc-33ec-77d795f81555@oracle.com>
Message-ID: <20180430062542.hpqirk27ensxhkd2@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> Hi Petr,


> What about using TST_OPTS and TST_PARSE_ARGS here, instead of 'while getopts...'
> and 'shift'?

> virt_parse_args()
> {
>         case "$1" in
>         h)
>            ...
>         ;;
>         i) start_id=$OPTARG ;;
>         d) vxlan_dst_addr=$OPTARG ;;
>         esac
> }

> TST_OPTS="hi:d:"
> TST_PARSE_ARGS=virt_parse_args

Sure :). Thanks for reminding me my own code :).
I've sent v2 with it, can you have a quick look?


Kind regards,
Petr
