From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 11 Mar 2016 22:10:41 +0800
Subject: [LTP] [PATCH 2/3] network/stress: add ipsec lib
In-Reply-To: <56E2AA00.90902@oracle.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-3-git-send-email-haliu@redhat.com>
 <56E01A1E.4070401@oracle.com>
 <20160311053414.GQ2649@Leo.nay.redhat.com>
 <56E2AA00.90902@oracle.com>
Message-ID: <20160311141040.GS2649@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 11, 2016 at 02:20:32PM +0300, Alexey Kodanev wrote:
> Hi,
> On 03/11/2016 08:34 AM, Hangbin Liu wrote:
> >On Wed, Mar 09, 2016 at 03:42:06PM +0300, Alexey Kodanev wrote:
> >>>+# c2x: convert charactor to hex
> >>>+c2x()
> >>>+{
> >>>+	for str in $@; do
> >>>+		for (( i=0; i<${#str}; i++ )); do
> >>Not portable "for (());", could be changed to "for i in $(seq 0 ${#str});
> >>do.
> >Hi Alexey,
> >
> >Since we need to use the number from 0 to str_len - 1. I think it's also
> >not portable if we use like "for i in $(seq 0 $((${#str} - 1))); do". So I
> >will keep the format. Please tell me if you have any other suggestion.
> 
> No, double parentheses for arithmetic is fine, at least bash, dash and
> ash support it.
> 
> Also, we could use hexdump, xxd, etc...
> 
> c2x()
> {
>     printf "$@" | hexdump  -e '/1 "%x"'
> }

Thanks for this tip. I tested but there seems some different with the old one.
I will look into it.

BTW. I tried to use ROD to run cmds like ROD ip xfrm state flush. But it failed
with error like

/opt/ltp/testcases/bin/test.sh: line 232: flag: unbound variable

Do you know why?

Thanks
Hangbin
