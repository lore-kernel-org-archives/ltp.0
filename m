From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 17:12:18 +0200
Subject: [LTP] [PATCH] utimensat_tests.sh: returns EPERM on 4.4.27 and
	above
In-Reply-To: <1297668995.23147365.1506520513918.JavaMail.zimbra@redhat.com>
References: <1504697434-22974-1-git-send-email-naresh.kamboju@linaro.org>
 <1059184676.9072017.1504698860809.JavaMail.zimbra@redhat.com>
 <CAO_48GG9k_MxhktOWptCkv1Y8xFfFN31w2ntcnkZL5LdhM7qxg@mail.gmail.com>
 <20170925144624.GB31931@rei>
 <1297668995.23147365.1506520513918.JavaMail.zimbra@redhat.com>
Message-ID: <20170927151218.GA31500@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But also less strict. Why not just add check for 3rd digit?
> We already do that in other tests.

If that works for everyone, let's go with it. I just want to avoid a
need to maintain a maze of kernel versions.

-- 
Cyril Hrubis
chrubis@suse.cz
