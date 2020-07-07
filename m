From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Jul 2020 08:37:03 -0400 (EDT)
Subject: [LTP] [PATCH v2] Add mincore() test for anonymous mappings
In-Reply-To: <20200706050828.5134-1-shwetha@zilogic.com>
References: <20200706050828.5134-1-shwetha@zilogic.com>
Message-ID: <1535756409.1079792.1594125423402.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> Changes from v1:
> 	1.Changed testcase description.
> 	2.Checked ptr before executing SAFE_MUNMAP() in cleanup().
> 	3.Added a setup() fuction.
> 	4.Fixed formatting issues.
> 	5.Changed TPASS and TFAIL messages.
> 	6.Changed syntax for conditional statements.
> 
> References: #461
> 
> Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

