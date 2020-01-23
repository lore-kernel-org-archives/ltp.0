From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2020 18:54:59 -0500 (EST)
Subject: [LTP] [PATCH v2] Fix prctl02
In-Reply-To: <20200123151836.29484-1-mdoucha@suse.cz>
References: <239304412.3515101.1579791334045.JavaMail.zimbra@redhat.com>
 <20200123151836.29484-1-mdoucha@suse.cz>
Message-ID: <1063406316.3604310.1579823699778.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The prctl() system call takes 5 integer arguments but only 3 of them were
> passed in the test. This means that the system call read random garbage
> from stack in place of the two missing arguments and failed even on some
> perfectly valid combinations of arguments on some platforms.
> 
> - Change num_invalid to ULONG_MAX
> - Fix arguments in test case 9, 13 and 14
> - Fix test call of prctl() to have all 5 arguments
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> CC: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

