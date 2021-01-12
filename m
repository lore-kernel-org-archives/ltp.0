From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 12 Jan 2021 10:57:44 +0100
Subject: [LTP] [PATCH v5 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <CAEemH2e_5gCmtieHVDiXRv27=hPA+ZOyH+vRSjkhnRO5e=ZcxA@mail.gmail.com>
References: <20210111161103.22433-1-mdoucha@suse.cz>
 <20210111161103.22433-2-mdoucha@suse.cz>
 <CAEemH2e_5gCmtieHVDiXRv27=hPA+ZOyH+vRSjkhnRO5e=ZcxA@mail.gmail.com>
Message-ID: <194adee8-76e5-f83a-d2dc-b6078cc0a513@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12. 01. 21 9:34, Li Wang wrote:
> We have to include?the "tst_private.h" header file otherwise compiler
> failed to build it.

Right, sorry. I ran a clean build after moving the declaration and
didn't notice the implicit declaration warning. I'll resubmit in a moment.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
