From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 6 Nov 2018 14:45:13 -0500 (EST)
Subject: [LTP] [PATCH] getrlimit/getrlimit03: new test for
	underlying	syscall variants
In-Reply-To: <20181106180804.163305-1-ghackmann@google.com>
References: <20181106180804.163305-1-ghackmann@google.com>
Message-ID: <629612842.70327511.1541533513279.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
<snip>

> +const uint64_t RLIM_INFINITY_U64 = UINT64_MAX;
> +
> +static int getrlimit_u64(int resource, struct rlimit64 *rlim)
> +{
> +	return syscall(__NR_prlimit64, 0, resource, NULL, rlim);

Hi,

(Likely an issue for old distro kernels, but)
consider using ltp_syscall here, or in setup(). Syscall __NR defines
come from LTP, so those will be always present, but syscall can still
be unsupported by kernel, so test can end up comparing with 'ENOSYS'.

Regards,
Jan
