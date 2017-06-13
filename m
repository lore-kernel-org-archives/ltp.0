From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Jun 2017 07:18:35 -0400 (EDT)
Subject: [LTP] [PATCH] Fix mmap01 testcase on hppa architecture
In-Reply-To: <20170609145328.GA7129@ls3530>
References: <20170609145328.GA7129@ls3530>
Message-ID: <2130257221.33914320.1497352715953.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The mmap() syscall to map a file at any given page-aligned address (via the
> MAP_FIXED flag) can fail on the hppa architecture due to cache colouring
> requirements of the architecture.
> 
> This patch drops the MAP_FIXED flag and thus maps the file instead at
> some convenient address based on the hint as given by the addr
> parameter.

It looks like we don't need addr at all. Test is remapping part
of heap with MAP_FIXED, which looks risky. I'd drop that page
initialisation inside heap too. Now, without MAP_FIXED, it's
just completely unrelated page. What do you think?

Regards,
Jan

