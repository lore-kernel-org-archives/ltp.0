From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Mar 2020 19:09:08 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
In-Reply-To: <20200317182704.GB10442@yuki.lan>
References: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
 <CAEemH2f5sMfOX5XjEOr8cmLRwu+YzMziEwRFPAegG+FAURi90A@mail.gmail.com>
 <20200317182704.GB10442@yuki.lan>
Message-ID: <CAEemH2eHDQJdWwZNDPT+RqdrTNdr9HWX7i2vOEaZwB1LRoN5Xg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 17, 2020 at 6:43 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Do we really need to enable the open_posix_testsuite explicitly? By
> > default, LTP uses "--with-open-posix-testsuite" as the configure
> parameter
> > to enabling it, is that work for you?
>
> Even if we wanted to enable openposix by default, which may be a good
> idea, we should change the default in configure.ac instead with:
>

Yes, your method looks better. But I'd suggest giving more time on bug
fixing before enabling open_posix_testsuit explicitly, other than
publishing that with many build issues. Seems Zou and Xu are working on
this part recently, that would be appreciated if more patches work out.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200317/14fe14f9/attachment.htm>
