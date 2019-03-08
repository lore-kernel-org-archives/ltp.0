From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Mar 2019 14:27:08 +0100
Subject: [LTP] [PATCH 2/2 v2] libs: Hook up libs into the build system
In-Reply-To: <1327941462.6119620.1552050333572.JavaMail.zimbra@redhat.com>
References: <20190308124257.25282-1-chrubis@suse.cz>
 <20190308124257.25282-2-chrubis@suse.cz>
 <1327941462.6119620.1552050333572.JavaMail.zimbra@redhat.com>
Message-ID: <20190308132708.GA20072@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What if we added "libs" as dependency for all tests and always expanded
> LDFLAGS for all libraries even if tests don't link against them?
> Then we wouldn't need to specify "LTPLIBS". Just a thought.

That way if we ever wanted to fix the "rebuild tests after library
change" it will will rebuild a whole LTP even after change in a library
that is used in just a few packages...

-- 
Cyril Hrubis
chrubis@suse.cz
