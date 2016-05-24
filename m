From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 14:54:47 +0200
Subject: [LTP] [PATCH] ppoll01: rewrite in new API
In-Reply-To: <72553830.252358.1464078913365.JavaMail.zimbra@redhat.com>
References: <d7a24122b97ae88bdeb9d864240137494d52ee0c.1464077434.git.jstancek@redhat.com>
 <72553830.252358.1464078913365.JavaMail.zimbra@redhat.com>
Message-ID: <20160524125446.GF10029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void cleanup(void)
> > +{
> > +	SAFE_CLOSE(fd1);
> > +	SAFE_UNLINK("testfile1");
> 
> ^^ These shouldn't be safe macros. I noticed it too late.

And the close(fd1) should be done only if it was opened.

But otherwise the test looks much better after this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
