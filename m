From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Feb 2020 15:38:33 +0800
Subject: [LTP] running aio02 test in ltp giving CONF: test requires
 libaio and its development packages
In-Reply-To: <BMXPR01MB299909AAA91463BB4254C091EE190@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB299944A5CB7B89E2F51B71D8EE190@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
 <BMXPR01MB299909AAA91463BB4254C091EE190@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <CAEemH2cuXyACFnJbCUwPid7RiCTENZZgtCsSGctE=ph-MN8DUg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Pankaj,

On Mon, Feb 10, 2020 at 3:19 PM Pankaj Vinadrao Joshi <
Pankaj.VJ@exaleapsemi.com> wrote:

>
> ------------------------------
>
> Hi,
> with reference to the above subject i am testing aio02 in ltp in ltp,when
> i am trying to run that test it is giving  *CONF: test requires libaio
> and its development packages*
> as o/p how i can work around the problem?
> i have already installed some libaio packages through
>
> $apt-get install libaio1 && $apt-get install libaio-dev
>
> anything else that needs to be installed?
>

I'm not using ubuntu distro, but from my experience, you probably need to
rebuild your LTP after the packages(libaio1, libaio-dev) install.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200210/66e72728/attachment.htm>
