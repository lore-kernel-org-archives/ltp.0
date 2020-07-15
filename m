From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 14 Jul 2020 20:58:12 -0400
Subject: [LTP] [PATCH 1/2] IMA: Verify that the kernel cmdline is passed
 and measured correctly through the kexec barrier.
In-Reply-To: <20200702153545.3126-2-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
Message-ID: <1594774692.12900.220.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> Add a testcase that verifies that kexec correctly logs the
> kernel command line to the IMA buffer and that the command
> line is then correctly measured.
> 
> This test must be run standalone, since it runs kexec
> multiple times (and therefore reboots several times).

Verifying the kexec boot command line doesn't require rebooting. ?Just
loading the kexec kernel image should be enough (kexec -s -l).
?Verifying that the measurement list, including the kexec boot command
line, is carried across kexec could be a separate test.

Mimi
