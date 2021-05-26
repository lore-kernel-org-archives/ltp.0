From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 May 2021 13:34:02 +0200
Subject: [LTP] Recent Yocto Project LTP experiences (hangs)
In-Reply-To: <0dc10bb052f327dc4c76d01dc70930bebc6bf151.camel@linuxfoundation.org>
References: <0dc10bb052f327dc4c76d01dc70930bebc6bf151.camel@linuxfoundation.org>
Message-ID: <YK4yKsW9jPboFcZU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Just FYI, if you are running test in VMs you will be better with
runltp-ng that compared to ltp-pan is designed so that it drives qemu
and runs tests from the outside, which means that it can reboot the VM
automatically if testing gets stuck and continues with a next test. It
also logs kernel serial console so you get kernel traces in the result
file as well.

See: https://github.com/metan-ucw/runltp-ng

-- 
Cyril Hrubis
chrubis@suse.cz
