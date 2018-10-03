From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Oct 2018 09:42:40 +0200
Subject: [LTP] [RFC PATCH 4/5] runtest/commands: adjust names for
 keyctl01, sysctl01, unshare01
In-Reply-To: <bf0bbc7d-e1f8-bad1-b07a-cecfc34ab968@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181002130338.GG24796@rei>
 <bf0bbc7d-e1f8-bad1-b07a-cecfc34ab968@oracle.com>
Message-ID: <20181003074240.GB23398@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As if
> 
> keyctl01 keyctl01.sh
> 
> was changed to
> 
> keyctl01_sh keyctl01.sh
> 
> Correct?

Or we can, for the cases where command has the same name as syscall,
increment the numbers for the command tests by 50, that should avoid the
collisions.

So the keyctl01.sh will become keyctl51.sh.

-- 
Cyril Hrubis
chrubis@suse.cz
