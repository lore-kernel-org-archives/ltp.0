From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Oct 2018 11:02:41 +0200
Subject: [LTP] [RFC PATCH 4/5] runtest/commands: adjust names for
 keyctl01, sysctl01, unshare01
In-Reply-To: <29edc470-5eca-cd6d-f7ab-8c7a65eb9092@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181002130338.GG24796@rei>
 <bf0bbc7d-e1f8-bad1-b07a-cecfc34ab968@oracle.com>
 <20181003074240.GB23398@rei>
 <29edc470-5eca-cd6d-f7ab-8c7a65eb9092@oracle.com>
Message-ID: <20181008090241.GA23981@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Maybe we better stick to your previous proposal, i.e. adding _sh to the
> end of a name (in runtest files)? In my opinion, it's more clear and
> straightforward, i.e. if one has a look at a runtest file, it will take
> little time to understand why some tests have _sh at the end. Plus it
> doesn't require renaming of the sh test cases.
> 
> Shifting the numbering by a big number looks a bit tricky.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz
