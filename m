From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 10:42:28 +0100
Subject: [LTP] [PATCH 0/4] Convert tests to use new library
In-Reply-To: <20190325232012.67123-1-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
Message-ID: <20190326094228.GC17897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've only tested these with glibc + x86 vm. I removed some of the
> UCLINUX specific ifdefs in the process that I am not so sure about.
> Is there a way for me to test these on other systems?

The uClinux support has been deprecated and we are slowly removing the
support. The uClinux project itself seems to be dead so it does not make
sense to keep supporting it.

-- 
Cyril Hrubis
chrubis@suse.cz
