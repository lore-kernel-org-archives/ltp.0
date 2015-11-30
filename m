From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Nov 2015 18:12:09 +0100
Subject: [LTP] 64bit ld terminates for time01.c & write04.c
In-Reply-To: <CANKSX+E504F87K-3ZhaDPNcFLEVgv1oyRLeVV=vz69fMjSxtOw@mail.gmail.com>
References: <CANKSX+E504F87K-3ZhaDPNcFLEVgv1oyRLeVV=vz69fMjSxtOw@mail.gmail.com>
Message-ID: <20151130171209.GG11935@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm trying to cross compile the LTP to ARM 64bit and i am using
> aarch64-linux-gnu- tool chain for cross compiling. Entire LTP got
> compiled successfully except time01 and write04 tests due to ld
> returned with signal 11 and core is not dumped either for debugging.
> So i have collected strace for reference and attached is for time01.
> 
> aarch64-linux-gnu-gcc-4.8 -static -g -O2 -fno-strict-aliasing -pipe
> -Wall -W -Wold-style-definition
> -I/home/Srikanth/ltp-working/testcases/kernel/include
> -I../../../include -I../../../include -static -pthread  -L../../../lib
>  time01.c   -lltp -o time01
> collect2: error: ld terminated with signal 11 [Segmentation fault], core dumped
> make: *** [time01] Error 1

Most likely you have found a bug in your binutils (which is the package
the ld comes from) and this is a wrong mailing list to report the
problem to, try mailing list or bugzilla listed at
https://www.gnu.org/software/binutils/.

-- 
Cyril Hrubis
chrubis@suse.cz
