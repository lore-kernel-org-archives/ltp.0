From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 14:06:17 +0200
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
In-Reply-To: <677837031.3058710.1471348255113.JavaMail.zimbra@redhat.com>
References: <20160804144508.GA8001@rei.lan>
 <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
 <20160816113451.GA25092@rei.lan>
 <677837031.3058710.1471348255113.JavaMail.zimbra@redhat.com>
Message-ID: <20160816120617.GB25092@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'd go with dummy if (). I think we should try to keep warnings down,
> at least for lib. I always check compilation output, and one less
> warning to go through each time is IMO worth making this simple workaround.

Pushed with that change.

-- 
Cyril Hrubis
chrubis@suse.cz
