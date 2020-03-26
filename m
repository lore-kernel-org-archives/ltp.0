From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Mar 2020 18:08:09 +0300
Subject: [LTP] [PATCH 0/2] xinetd rewrite
In-Reply-To: <20200324093622.21091-1-pvorel@suse.cz>
References: <20200324093622.21091-1-pvorel@suse.cz>
Message-ID: <fb9ee711-f42d-3dd0-a2ef-1685aef951af@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24.03.2020 12:36, Petr Vorel wrote:
> Hi Alexey,
> 
> this sounds as a bad joke to rewrite tests for xinetd, which nobody uses
> now. I was surprised, that it's still in some distros (e.g. openSUSE,
> Debian, Gentoo). I can delete the test if we don't want LTP to be a
> museum.
> 
Hi Petr,

Perhaps, it is true for inetd, not for xinetd.

The changes look good, acked.

> Kind regards,
> Petr
> 
> Petr Vorel (2):
>   xinetd: Rewrite into new API
>   xinetd: Fix pattern for NetKit telnet
> 
>  testcases/network/xinetd/xinetd_tests.sh | 99 ++++++++----------------
>  1 file changed, 33 insertions(+), 66 deletions(-)
> 
