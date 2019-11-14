From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 14 Nov 2019 09:09:33 +0100
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
 <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
Message-ID: <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>
>     Defining AC_ARG_WITH within an if to express dependencies does not
>     work.
>     ./configure --with-realtime-testsuite set with_realtime_testsuite=yes,
>     even if with_bash=no or with_python=no. The check is removed
>     completely.
>
>
> Or, maybe we can make use of AS_IF here? and I noticed there are many 
> places that use "if test ..." in the configure.ac 
> <http://configure.ac> file. That looks?tangly...
I left a TODO in there so it can be fixed later, maybe together with 
other errors. I think this does not block merging this patch first?
The python requirement for realtime-testsuite is outdated/wrong anyway, 
if I remember correctly. A colleague of mine recently
investigated the python requirement and we came to the conclusion, that 
it is not needed for running the test.
I think it was used only for manual test result evaluation.

So there seems to be more work regarding dependencies between configure 
options.

J?rg
