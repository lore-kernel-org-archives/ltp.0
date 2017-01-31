From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Jan 2017 13:09:43 +0100
Subject: [LTP] utimensat EACCES vs. EPERM in 4.8+
In-Reply-To: <cb15e28d-8c5e-e3d7-441a-9165c4e57133@gmail.com>
References: <18a5b416-ad6a-e679-d993-af7ffa0dcc10@redhat.com>
 <CAOssrKfb1-C8c=9bAPiairh+Lyf=w28r+RjSXTLQcQZ-=eWMRA@mail.gmail.com>
 <CAKgNAkjTkBMY0wrj3wsH39YF=bHp=8mbYrXkSPzn0X4ezfso1w@mail.gmail.com>
 <280513509.810300.1484639500985.JavaMail.zimbra@redhat.com>
 <20170117075702.GB10417@rei.lan>
 <CAOssrKd32K-e5794m9KOjrMm_E3VZ7P-bvZW2P8UpGFTOgi8JQ@mail.gmail.com>
 <cb15e28d-8c5e-e3d7-441a-9165c4e57133@gmail.com>
Message-ID: <20170131120929.GE29227@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> All of this said, I still don't know whether reverting the patch
> is warranted...

Ping.

What shall we do with the failing testcase?

I guess that since the discussion withered the patch will stay in kernel
as it is and the manual needs to be updated...

-- 
Cyril Hrubis
chrubis@suse.cz
