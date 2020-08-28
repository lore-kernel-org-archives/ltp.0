From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Aug 2020 15:06:38 +0200
Subject: [LTP] [RFC] ltp test add reboot function
In-Reply-To: <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
References: <CAF12kFuE=4-T=eitwSb0F3fkGLLsmM3VEg4VNbioqJt2JiAEww@mail.gmail.com>
 <20200824074226.GB2466@yuki.lan>
 <CAF12kFvScxqxhY5wXTGL2RKnyM5vM0hEKDc+sHD-3Y=_C7FWcw@mail.gmail.com>
Message-ID: <20200828130638.GD10501@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for you experiences on the reboot???
> So far my opinion is add a reboot service by chkconfig or something like that.
> the service will start runltp scripts from last break off point.
> when the tst_test have .tst_needs_reboot =1 flag, it wil strore the
> run status and
> reboot the machine before run the test case.
> Now I want to know what needs to be preserved???

The runltp script and ltp-pan cannot save and restore a testrun,
although something like that may be possible to implement, I doubt that
it could be easily added to the current infrastructure. Not to mention
that ltp-pan has been in a maintenance mode (which means no new
features) for years now.

Also I do consider the whole concept of running the test exectution
framework on the same machine as the testcases broken by desing for
kernel related tests. The way forward is the patchset send by Richard
that implements simple test executor that runs on the machine under test
and communicates with a execution framework that runs on a central
server.

-- 
Cyril Hrubis
chrubis@suse.cz
