Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RxDEG-0008UP-MZ
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 07:55:12 +0000
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxDEA-0003eK-Gk
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 07:55:12 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8604DE9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 07:54:45 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49BD41976
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 07:54:45 +0000 (GMT)
Message-ID: <4F3A1342.5030109@st.com>
Date: Tue, 14 Feb 2012 08:54:42 +0100
From: "Salvatore CRO'" <salvatore.cro@st.com>
MIME-Version: 1.0
References: <4F39D61D.80309@cn.fujitsu.com>
In-Reply-To: <4F39D61D.80309@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] clone06: fix error of TERM environment variable
 is not available
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On 2/14/2012 4:33 AM, Peng Haitao wrote:
> When TERM environment variable is not available, the case may be fail.
> The patch use the following steps:
> 1. unset a predetermined env variable if it's present.
> 2. set it to a known value
> 3. Make sure that the env variable set in 2. matches both in the child
>     and parent.

Humm... I'm not so keen on this solution as it sounds like a .... IMO.

The case when env variable is not defined should be treated the same 
way. This
proves once again that both parent and child get the same results.

If your execution ends up with

clone06     0  TWARN  :  sprintf() failed: errno=???(0): Success

when TERM is not defined, this is because sprintf check is not correct :

         if ((sprintf(var, "%s", getenv("TERM") ? : "")) <= 0) {
                 tst_resm(TWARN|TERRNO, "sprintf() failed");
         }

In this case var is evaluated to "" and sprintf will return "0 byte 
read" that is quite acceptable.
Child will face an analogue situation so test will pass.

Correct patch should be to change sprintf check to :

if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0) {
                 tst_resm(TWARN|TERRNO, "sprintf() failed");
         }

I will send it asap...

Ciao,
Salvo.

> Signed-off-by: Peng Haitao<penght@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/clone/clone06.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
> index 1734776..5701e4a 100644
> --- a/testcases/kernel/syscalls/clone/clone06.c
> +++ b/testcases/kernel/syscalls/clone/clone06.c
> @@ -165,6 +165,15 @@ int main(int ac, char **av)
>   void setup()
>   {
>
> +	char *term;
> +
> +	term = getenv("TERM");
> +	if (term)
> +		if (unsetenv("TERM") == -1)
> +			tst_brkm(TBROK|TERRNO, NULL, "unsetenv failed");
> +	if (setenv("TERM", "xterm", 1) == -1)
> +		tst_brkm(TBROK|TERRNO, NULL, "setenv failed");
> +
>   	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>
>   	TEST_PAUSE;


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
