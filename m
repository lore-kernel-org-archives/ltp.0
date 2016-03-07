From: Cui Bixuan <cuibixuan@huawei.com>
Date: Mon, 7 Mar 2016 19:08:40 +0800
Subject: [LTP]  max_map_count fail in arm64 system which support lib32
Message-ID: <56DD6138.9060109@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
    There is an error when run 32-bit 'max_map_count' in arm64 which support lib32:

./max_map_count_32
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
max_map_count    1  TFAIL  :  max_map_count.c:233: 64 map entries in total, but expected 64 entries
max_map_count    0  TINFO  :  set max_map_count to 256
max_map_count    2  TFAIL  :  max_map_count.c:233: 256 map entries in total, but expected 256 entries
max_map_count    0  TINFO  :  set max_map_count to 1024
max_map_count    3  TFAIL  :  max_map_count.c:233: 1024 map entries in total, but expected 1024 entries
max_map_count    0  TINFO  :  set max_map_count to 4096
max_map_count    4  TFAIL  :  max_map_count.c:233: 4096 map entries in total, but expected 4096 entries
max_map_count    0  TINFO  :  set max_map_count to 16384
max_map_count    5  TFAIL  :  max_map_count.c:233: 16384 map entries in total, but expected 16384 entries
max_map_count    0  TINFO  :  set max_map_count to 65536
max_map_count    6  TFAIL  :  max_map_count.c:233: 65536 map entries in total, but expected 65536 entries
max_map_count    0  TINFO  :  set overcommit_memory to 0
max_map_count    0  TINFO  :  set max_map_count to 65530

    When I use 32-bit SDK, it will compile at:

	#elif defined(__arm__)
        	/* Older arm kernels didn't label their vdso maps */
        	if (!strncmp(line, "ffff0000-ffff1000", 17))
                	return true;

    and not:
	#elif defined(__ia64__)
        	/* On ia64, the vdso is not a proper mapping */
        	if (!strcmp(buf, "[vdso]"))
                	return true;


    That will fail in arm64 because of the wrong check; And I have a look at x86 and x86_64, which
have the same check '[vsyscall]';
    I think we should fix it but I don't have good idea( I don't know much about it :-( ).

Thanks,
Cui Bixuan




