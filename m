From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Jun 2018 10:55:14 +0200
Subject: [LTP] LTP syscall fcntl36 test is fails intermittently on arm32
 qemu and beagleboard x15
In-Reply-To: <CA+G9fYu9CyOrQajZ-iupDwshydg=pLiQVyzTs96e-A4HFNrMPA@mail.gmail.com>
References: <CA+G9fYu9CyOrQajZ-iupDwshydg=pLiQVyzTs96e-A4HFNrMPA@mail.gmail.com>
Message-ID: <20180611085514.GB16808@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP syscall fcntl36 test is failing intermittently on arm32 qemu and
> beagleboard x15 device. We have to find a solution to fix this test
> case on arm32.

I've seen similar failures when 32bit fcntl36 binary is executed on
x86_64, so far we haven't figured out what is wrong here.

-- 
Cyril Hrubis
chrubis@suse.cz
