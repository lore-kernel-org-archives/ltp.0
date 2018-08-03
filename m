From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 3 Aug 2018 11:32:36 -0400 (EDT)
Subject: [LTP] [PATCH] mknod03: Skip S_ISGID check on files created by
 non-group members.
In-Reply-To: <20180803152225.21107-1-sspatil@google.com>
References: <20180803152225.21107-1-sspatil@google.com>
Message-ID: <117811695.38227690.1533310356033.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 0fa3ecd87848 ("Fix up non-directory creation in SGID directories") fixes
> problem described in CVE-2018-13405. This commit is backported to older
> streams as well.
> 
> This patch removes S_ISGID check for files created by non-group members
> in LTP tests mknod03. Basically, does the same thing as commit
> '3c87ef2961' for mknod03 test.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>

Pushed.

Regards,
Jan
