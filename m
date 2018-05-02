From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 May 2018 13:47:42 +0200
Subject: [LTP] LTP master testing on arm64 hikey
In-Reply-To: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
References: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
Message-ID: <20180502114742.GA30510@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> utimensat01 1 TBROK: can't read /etc/sudoers
> https://lkft.validation.linaro.org/scheduler/job/203110#L12218

Well the testcase is probably worth of rewriting, since it depends on
using sudo to run certain commands as a test user from a shell script.

Rewriting it to C would fix this kind of problems.

-- 
Cyril Hrubis
chrubis@suse.cz
