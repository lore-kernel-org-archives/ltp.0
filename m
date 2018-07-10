From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Jul 2018 09:53:55 -0400 (EDT)
Subject: [LTP] [PATCH] acl_test01: Add setfacl as an explicit dependency
In-Reply-To: <20180706152927.26646-1-punit.agrawal@arm.com>
References: <20180706152927.26646-1-punit.agrawal@arm.com>
Message-ID: <690628691.31612421.1531230835933.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> acl_test01 calls setfacl during execution but does not explicitly
> check for its presence during setup.
> 
> Add this dependency to correctly report the failure mode when setfacl
> is not found.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Pushed.

Thanks,
Jan
