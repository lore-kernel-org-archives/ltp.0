From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jun 2020 12:10:02 +0200
Subject: [LTP] [Automated-testing] [PATCH 1/2] tst_test: Add support for
 device discovery
In-Reply-To: <CAF12kFvBj+9AF5AoJK=Varb0ZVGCNqW++8cS=j4BQRGxdQY=gw@mail.gmail.com>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
 <574e52f4-8988-a562-57c5-274a86e6e8cb@xilinx.com>
 <20200624090523.GA29350@yuki.lan>
 <adafab63-4390-a4a3-b3aa-923b31d5ac37@xilinx.com>
 <20200624092940.GA30917@yuki.lan>
 <CAF12kFvBj+9AF5AoJK=Varb0ZVGCNqW++8cS=j4BQRGxdQY=gw@mail.gmail.com>
Message-ID: <20200624101002.GB30917@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> in the ltp-ddt test script ,it  can auto detect which serial devices are on
> the machine, and filter out the serial ports in used???So I am more
> concerned about whether it can have this function in  the device-discovery.sh

That's the piece that is lab specific and used in your lab, there will
be no offical script and you are supposed to maintain it yourself.

The approach here is to isolate all the lab specific details into a
single place since that code does not belong to the LTP upstream
codebase.

-- 
Cyril Hrubis
chrubis@suse.cz
