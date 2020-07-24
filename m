From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Jul 2020 15:37:26 +0200
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200724103454.ttaqxq3hzmth7gpr@vireshk-mac-ubuntu>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
 <20200724055826.GE32086@dell5510>
 <20200724103454.ttaqxq3hzmth7gpr@vireshk-mac-ubuntu>
Message-ID: <20200724133726.GB31265@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> > Although these errors are still here:

> I went to libs/ directory and I don't get any warnings with

> $ make clean; make

> How can I generate these easily ?
Use new gcc. I was able to generate this even with gcc 9:

$ gcc --version
gcc (SUSE Linux) 9.3.1 20200406 [revision 6db837a5288ee3ca5ec504fbd5a765817e556ac2]
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Kind regards,
Petr
