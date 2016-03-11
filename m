From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 11 Mar 2016 13:34:14 +0800
Subject: [LTP] [PATCH 2/3] network/stress: add ipsec lib
In-Reply-To: <56E01A1E.4070401@oracle.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-3-git-send-email-haliu@redhat.com>
 <56E01A1E.4070401@oracle.com>
Message-ID: <20160311053414.GQ2649@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 09, 2016 at 03:42:06PM +0300, Alexey Kodanev wrote:
> >+# c2x: convert charactor to hex
> >+c2x()
> >+{
> >+	for str in $@; do
> >+		for (( i=0; i<${#str}; i++ )); do
> 
> Not portable "for (());", could be changed to "for i in $(seq 0 ${#str});
> do.

Hi Alexey,

Since we need to use the number from 0 to str_len - 1. I think it's also
not portable if we use like "for i in $(seq 0 $((${#str} - 1))); do". So I
will keep the format. Please tell me if you have any other suggestion.

Thanks
Hangbin
