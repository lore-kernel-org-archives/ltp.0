From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 13:36:05 +0200
Subject: [LTP] [PATCH] [6/6] syscalls/sysfs: Convert sysfs06 to the new
 API
In-Reply-To: <20210806113115.8852-1-sujiaxun@uniontech.com>
References: <20210806113115.8852-1-sujiaxun@uniontech.com>
Message-ID: <YRJkpZCn1Oii1xFM@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
And this is nearly the same as sysfs05, the only test that is missing in
sysfs05 is fs index out of bounds. So we should add that test to
sysfs05 and remove sysfs06.

-- 
Cyril Hrubis
chrubis@suse.cz
