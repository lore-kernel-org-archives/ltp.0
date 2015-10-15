From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Oct 2015 16:11:02 +0200
Subject: [LTP] getpwnam(nobody) failed
In-Reply-To: <CANKSX+GTDu9Ce9UUmfWo4E4+uxNi9Dh8Ek=a9J2YM1=4sAZ9Pw@mail.gmail.com>
References: <CANKSX+GTDu9Ce9UUmfWo4E4+uxNi9Dh8Ek=a9J2YM1=4sAZ9Pw@mail.gmail.com>
Message-ID: <20151015141101.GB20237@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Need some help in understanding the behavior of failure cases though
> user 'nobody' is present. I am unable to figure it out as i am running
> them on android kernel.

I glanced over the bionic libc for android and it looks like /etc/passwd
is not used at all. The calls are emualted using some android_id_info
database there. I'm afraid that you have to look deeper into the bionic
libc to figure out how exactly this works.

-- 
Cyril Hrubis
chrubis@suse.cz
