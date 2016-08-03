From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 17:34:19 +0200
Subject: [LTP] [PATCH] tst_test: Allow to set timeout from test setup()
In-Reply-To: <1951597278.861795.1470238415053.JavaMail.zimbra@redhat.com>
References: <20160803135355.GA30335@rei.lan>
 <1896180212.843449.1470235129619.JavaMail.zimbra@redhat.com>
 <20160803150655.GB25589@rei>
 <1951597278.861795.1470238415053.JavaMail.zimbra@redhat.com>
Message-ID: <20160803153419.GC25589@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think that it will be safer to have it run with either with a default
> > timeout or with a test->timeout. And that is the whole point of setting
> > the timeout twice in case that we call tst_set_timeout() in the test
> > setup().
> 
> Good point, so setting timeout twice seems unavoidable.
> But I'm still thinking about actions needed to set timeout
> that are now not part of tst_set_timeout(). Would it make sense
> to bring those in?

Looks good to me. I will merge your changes into my patch, add your
Signed-off-by and push it, OK?

-- 
Cyril Hrubis
chrubis@suse.cz
