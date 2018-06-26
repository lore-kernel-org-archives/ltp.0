From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 18:05:47 +0200
Subject: [LTP] runltp fails with Buildroot
In-Reply-To: <CA+Kjy2zehQeA8c1gfmj4jXDDdPwdTWkS41aH=B7guXnRDS8m4A@mail.gmail.com>
References: <CA+Kjy2zzPOUcUP7yYu-OcA4NrKhp+fNW9PNObfxiAuPWsUw0eg@mail.gmail.com>
 <20180625134200.GB24288@rei>
 <CA+Kjy2zehQeA8c1gfmj4jXDDdPwdTWkS41aH=B7guXnRDS8m4A@mail.gmail.com>
Message-ID: <20180626160543.GA24350@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Now I am able to run runltp on my raspberry pi target. I have added a new
> i2c test case under testcases folder, please help me how could I run this
> test alone with runltp and email the result.
> 
> I executed as follows
> 
> . /runltp -a <email > -p -o output.log <path to LTP in the
> target>/testcases/bin/<testname>
> 
> When I executed the above all the test are running.

You need to create a runtest entry/file under the runtest directory,
then you can select which runtest files to execute with runltp -f.

-- 
Cyril Hrubis
chrubis@suse.cz
