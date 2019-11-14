From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Nov 2019 06:43:33 -0500 (EST)
Subject: [LTP] [PATCH] mbind04: terminate child processes
In-Reply-To: <20191114104221.GB30308@rei>
References: <51aabb2e4680d830b5ba7b7623e0c7697bcb6338.1573675056.git.jstancek@redhat.com>
 <20191114104221.GB30308@rei>
Message-ID: <560257538.12094870.1573731813438.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> I find the name for the variable quite confusing here, because it
> suggests that the parent exits here, while the opposite is true. Can we
> please just use pid or something less confusing for the variable name?

Pushed with renamed variable.

