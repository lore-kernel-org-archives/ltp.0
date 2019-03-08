From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Mar 2019 12:34:31 +0100
Subject: [LTP] [PATCH] Fix build with libnuma-dev on some distributions
In-Reply-To: <20190308104338.GA16584@dell5510>
References: <20190307143453.9808-1-chrubis@suse.cz>
 <361211632.5905441.1551973237001.JavaMail.zimbra@redhat.com>
 <20190308104338.GA16584@dell5510>
Message-ID: <20190308113430.GA22791@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + other LTP libraries are hidden in some subdirectories (which might be
> confusing), but I like there is not lib/ and lib<foo>/ in root directory.

We can add a libs/ directory to the top level directory and put all libs
shared between significant number of tests in different places there.
How does this sound?

-- 
Cyril Hrubis
chrubis@suse.cz
