From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 18 Nov 2019 07:40:40 +0100
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <20191118061634.GA21536@x230>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
 <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
 <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
 <CAEemH2dPwqX1FtNvF7=hxbAfVMz7i_u+TpUBaU1mqKhY-G0Vig@mail.gmail.com>
 <20191118061634.GA21536@x230>
Message-ID: <4e9d5014-baea-98ba-c042-a65e5eca64e1@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
> I'm for merging this. I just wonder if it's not better to remove $with_bash and
> $with_python (as part of this patch), if they're not working.
I think you misunderstood. I did not say, that Bash and Python switches 
were not working,
just that the dependency of bash and python for realtime tests did not 
work -> it was not a dependency.
The realtime testsuite could be enabled without bash and python enabled.
