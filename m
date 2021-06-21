From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 21 Jun 2021 10:01:07 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <YNA+6shWiWYRNi2P@pevik>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de> <YKToUgBnK6ZQ5I0Q@yuki>
 <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de> <YNA+6shWiWYRNi2P@pevik>
Message-ID: <3fd9fb2f-3242-5268-eef3-0e5aa4faecef@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 6/21/2021 9:25 AM, Petr Vorel wrote:
> Hi all,
>
> I wonder what is the state of this patchset?
> Do we still consider it?
I still think this should be included, but we can drop shells if you like.
> Apart from reducing shells (i.e. which distro has ash, which is not
> alias to other shell in the list) I'm not against non-default shells, but I
> don't like how whole test gets complicated by this.
>
> Also we're reinventing wheel with printing results, checking whether test exist
> etc. Maybe using test API for this?
I know that this is reimplementing a lot of stuff, but I think I tried 
using the lib (a bit strange using the object under test to test it, but 
would be ok for me), but failed to do so.
I guess this was because it uses traps and the set -m stuff, but I am 
not sure anymore.

J?rg
