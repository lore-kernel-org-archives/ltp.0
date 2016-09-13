From: Carlos Hernandez <ceh@ti.com>
Date: Tue, 13 Sep 2016 09:29:19 -0400
Subject: [LTP] Number of testcases per releases - LTP
In-Reply-To: <CADKPhiNKGubuT2Pp-4PzhNodSm_E7AF96jyhsi6_PApSzVVCNg@mail.gmail.com>
References: <CADKPhiNKGubuT2Pp-4PzhNodSm_E7AF96jyhsi6_PApSzVVCNg@mail.gmail.com>
Message-ID: <5a16ca65-d16a-e540-8903-84baacfbf185@ti.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Jonatas,

Test cases are defined inside test scenario files. Each test case is 
defined on a line with  <Test TAG> <Test COMMAND> syntax.

Test scenario files are under runtest/ directory.

Regards,

Carlos



On 09/12/2016 10:18 PM, Jonatas Bastos wrote:
> I`m a PhD student interested in run some studies with the different 
> LTP releases. I would like to know how can I identify tests inside LTP 
> releases (i.e. number of testcases and module)
> Should I consider all .c files as tests in testcases folder?
> Should I consider all .sh files in testcases folder?
> If not, how should I identify a valid test case
>
> -- 
> Jonatas Bastos
> ------------------------------------------------------------ --------
> Professor de Computação no Instituto Federal (IFBA)
> M.Sc. Computer Science - CIn/UFPE
> skype: jonatasfbastos
> gtalk: jonatasfbastos@...
>
> “Face your fears, live your dreams"
>
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160913/ae959b59/attachment.html>
