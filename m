From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue, 16 May 2017 18:00:20 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170406124641.30179-1-chrubis@suse.cz>
References: <20170406124641.30179-1-chrubis@suse.cz>
Message-ID: <fef4d18a-8a38-1295-eb77-fceb192dc1ae@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/06/17 14:46, Cyril Hrubis wrote:
> This is proof of concept for building 32bit testcases on 64bit platform.

Not sure if LTP is supposed to run on these or if lib32 accounts for
them, just letting you know that they exist (and if the code doesn't
support them and adding support is easy, you might want to consider it):

* IBM System z (S390) has 31bit mode, not 32bit and the corresponding
  gcc flag is -m31, not -m32

* Some distros (ie. RHEL5 on PPC) have 32bit userspace by default, but
  have a secondary 64bit userspace mode - here, both -m32 and -m64 work,
  just the default is not -m64

* Some distros use the x32 ABI for userspace, -mx32, still being 32bit,
  but not -m32

Jiri

