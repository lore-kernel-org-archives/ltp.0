From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Mar 2019 18:00:08 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_test: Add test multiplex function
In-Reply-To: <1194364640.5702234.1551891235712.JavaMail.zimbra@redhat.com>
References: <20190306152430.25219-1-chrubis@suse.cz>
 <1194364640.5702234.1551891235712.JavaMail.zimbra@redhat.com>
Message-ID: <20190306170008.GE12479@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> on first look this looks like a workaround, because we have locked
> ourselves out of .test function for timer tests.

I do not follow you here, can you elaborate?

This patch has nothing to do with timer tests, it just allows whatever
the test does to be done several times with a hook to change some
settings prior to each iteration.

-- 
Cyril Hrubis
chrubis@suse.cz
