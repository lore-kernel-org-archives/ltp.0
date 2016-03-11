From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 11 Mar 2016 14:20:32 +0300
Subject: [LTP] [PATCH 2/3] network/stress: add ipsec lib
In-Reply-To: <20160311053414.GQ2649@Leo.nay.redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
 <1457334883-11086-3-git-send-email-haliu@redhat.com>
 <56E01A1E.4070401@oracle.com> <20160311053414.GQ2649@Leo.nay.redhat.com>
Message-ID: <56E2AA00.90902@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/11/2016 08:34 AM, Hangbin Liu wrote:
> On Wed, Mar 09, 2016 at 03:42:06PM +0300, Alexey Kodanev wrote:
>>> +# c2x: convert charactor to hex
>>> +c2x()
>>> +{
>>> +	for str in $@; do
>>> +		for (( i=0; i<${#str}; i++ )); do
>> Not portable "for (());", could be changed to "for i in $(seq 0 ${#str});
>> do.
> Hi Alexey,
>
> Since we need to use the number from 0 to str_len - 1. I think it's also
> not portable if we use like "for i in $(seq 0 $((${#str} - 1))); do". So I
> will keep the format. Please tell me if you have any other suggestion.

No, double parentheses for arithmetic is fine, at least bash, dash and
ash support it.

Also, we could use hexdump, xxd, etc...

c2x()
{
     printf "$@" | hexdump  -e '/1 "%x"'
}

if $@ contains strings separated by spaces, we could add

"tr -d' '" to it.

Best regards,
Alexey
