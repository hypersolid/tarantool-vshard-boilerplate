return {
        bucket_count = 16,
        sharding = {
            ['cbf06940-0790-498b-948d-042b62cf3d29'] = { -- replicaset #1
                replicas = {
                    ['8a274925-a26d-47fc-9e1b-af88ce939412'] = {
                        uri = 'storage:storage@127.0.0.1:33001',
                        name = 'storage_1_a',
                        master = true
                    }
                }
            }, 
            ['ac522f65-aa94-4134-9f64-51ee384f1a54'] = { -- replicaset #2
                replicas = {
                    ['1e02ae8a-afc0-4e91-ba34-843a356b8ed7'] = {
                        uri = 'storage:storage@127.0.0.1:33002',
                        name = 'storage_2_a',
                        master = true
                    }
                },
            }, 
        }
    }
