From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Apr 2021 15:57:41 +0200
Subject: [LTP] [PATCH] read_all: limit per cpu nodes to first ten cpus
In-Reply-To: <f776dd1a02dc16efa8aa80bbe6f9b55186dc82cd.1618321799.git.jstancek@redhat.com>
References: <f776dd1a02dc16efa8aa80bbe6f9b55186dc82cd.1618321799.git.jstancek@redhat.com>
Message-ID: <YHWjVd8+y3jwRCxb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Some per cpu sysfs entries have high lock contention and when
> this is combined with systems which have many CPUs (meaning they
> also have many per cpu sysfs entries) the test spends most of
> time on these nodes and occasionally also hits timeout.

> For example, these entries are largest contributor on HPE Apollo 70
> (aarch64, 256 CPUs):
>   /sys/kernel/tracing/per_cpu/cpu247/*
>   /sys/devices/system/cpu/cpu239/acpi_cppc/*

Acked-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
