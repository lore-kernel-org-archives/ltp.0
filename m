From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 17:01:14 +0200
Subject: [LTP] [PATCH 5/8] waitpid11: use the new API
In-Reply-To: <1468593589-30545-6-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1468593589-30545-6-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160718150113.GE18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This test does nearly the same as waitpid06, but here we pick up the
children by the process group instead of getting them all with -1 as a
pid.

I guess that we could create a function that would take an array of
pids, it's lenght and waitpid pid parameter and would assert that all
children pids in the array could be waited for. Then we could reuse the
function in waitpid06 passing whole array and -1 and here passing first
half of the array and 0 then second half of the array and -group...

-- 
Cyril Hrubis
chrubis@suse.cz
