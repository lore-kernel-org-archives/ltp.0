From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Oct 2017 14:59:58 +0200
Subject: [LTP] [PATCH] [RFC] tst_test: Add support for array of test
 functions
In-Reply-To: <860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com>
References: <20170727081437.27995-1-chrubis@suse.cz>
 <860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com>
Message-ID: <20171003125958.GB11692@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What would be the benefits?

I was aiming to avoid the need to have a switch () in each testcase that
implements a similar tests but cannot be easily data driven (as we do
for most of tests that loop over an array of structures describing the
test data).

The question is, of course, if the interface is worth the effort.

-- 
Cyril Hrubis
chrubis@suse.cz
