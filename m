From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Oct 2015 12:58:42 +0200
Subject: [LTP] LTP Question
In-Reply-To: <CAKxdZb9wLCrnKw+TBpYw-_1Usq+_yEwPOP54TeTPZsiTg=6WBw@mail.gmail.com>
References: <CAKxdZb-3b+K+p_dXy++rfMTFTSjvP+V9RTMVBt1Ac923d=jvwg@mail.gmail.com>
 <20151001121648.GG8256@rei.suse.cz>
 <CAKxdZb9wLCrnKw+TBpYw-_1Usq+_yEwPOP54TeTPZsiTg=6WBw@mail.gmail.com>
Message-ID: <20151005105841.GA17973@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks a lot for responding...
> Yes, the testcases/audit/ directory was never part of LTP, but we have
> downloaded "Red Hat LSPP_EAL4 + Re-Release" from following link:
> 
> "http://sourceforge.net/projects/ltp/files/EAL4%2B%20Certification%20Test%20Suite/Red%20Hat%20LSPP_EAL4%20%2B%20Re-Release/"
> 
> And the testcases/audit/ directory has added under /Test/LTP
> directory. In the TestPlan of EAL4 is required to executing the
> testcases/audit for evaluating Authentication and Identification. Now,
> I don't find these testcases in LTP-2015-04-20. If any testcases are
> replaced to evaluate Authentication of the OS, please help me about
> this matter.

As far as I know there are no testcases for audit in LTP. But there is a
separate audit-test project on LTP, have a look at:

http://sourceforge.net/projects/audit-test/

Also always keep the ltp@lists.linux.it in CC when discussing LTP.

-- 
Cyril Hrubis
chrubis@suse.cz
