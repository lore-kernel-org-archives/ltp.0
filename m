From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Nov 2019 07:16:34 +0100
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <CAEemH2dPwqX1FtNvF7=hxbAfVMz7i_u+TpUBaU1mqKhY-G0Vig@mail.gmail.com>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
 <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
 <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
 <CAEemH2dPwqX1FtNvF7=hxbAfVMz7i_u+TpUBaU1mqKhY-G0Vig@mail.gmail.com>
Message-ID: <20191118061634.GA21536@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Well, I just saw adding new #TODO here and hoping to solve this together, a
> simple way I was thinking is:

> +AS_IF([test "x$with_bash" != xyes || test "x$with_python" != xyes],
> +  [with_realtime_testsuite=no]
> +)

> Of course, It's fine to fix that in a separate patch!

I'm for merging this. I just wonder if it's not better to remove $with_bash and
$with_python (as part of this patch), if they're not working.

BTW better, than fixing bash/shell would be to actually rewrote tests which are
using python and bash to C or posix shell.
https://github.com/linux-test-project/ltp/issues/547

Kind regards,
Petr
