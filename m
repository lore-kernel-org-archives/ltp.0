From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 3 Sep 2020 15:19:13 +0200
Subject: [LTP] [PATCH v2 4/4] ioctl_sg01: Loop data leak check 100 times
In-Reply-To: <20200902171717.GC26811@dell5510>
References: <20200825160735.24602-1-mdoucha@suse.cz>
 <20200825160735.24602-5-mdoucha@suse.cz> <20200902171717.GC26811@dell5510>
Message-ID: <4c6dce78-8801-0ff2-43e5-7d518d79fdf9@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02. 09. 20 19:17, Petr Vorel wrote:
> BTW do I understand the test correctly: we expect ioctl() return -1 because we
> use uninitialized command[CMD_SIZE] in query.cmdp (as the requirement for empty
> command in kernel commit message)?

command[CMD_SIZE] is initialized to 0 which is the SCSI command TEST
UNIT READY. We expect ioctl() to return 0 but also ignore -1 because the
only thing we really care about are the contents of query.dxferp buffer.
If ioctl() fails for some legitimate reason but kernel still fills the
buffer with private data, we need to report that the CVE is present.

https://en.wikipedia.org/wiki/SCSI_command

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
