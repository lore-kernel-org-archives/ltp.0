From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Oct 2018 14:53:54 +0200
Subject: [LTP] [RFC PATCH 2/5] runtest/syscalls: rename CVE test cases
In-Reply-To: <1536849882-28897-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20181002125354.GE24796@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Can we do this the other way around?

I.e. rename the source files to match the syscall name and then patch
the cve runtest file to map the cve-* identifiers to the test names?

-- 
Cyril Hrubis
chrubis@suse.cz
